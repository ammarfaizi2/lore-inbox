Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271707AbTGRFmb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 01:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271708AbTGRFmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 01:42:31 -0400
Received: from mail.gmx.de ([213.165.64.20]:27535 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S271707AbTGRFm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 01:42:27 -0400
Message-Id: <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Fri, 18 Jul 2003 07:38:38 +0200
To: Davide Libenzi <davidel@xmailserver.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O6int for interactivity
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.55.0307161241280.4787@bigblue.dev.mcafeelabs.co
 m>
References: <200307170030.25934.kernel@kolivas.org>
 <200307170030.25934.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_702796==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_702796==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 03:12 PM 7/16/2003 -0700, Davide Libenzi wrote:

>http://www.xmailserver.org/linux-patches/irman2.c
>
>and run it with different -n (number of tasks) and -b (CPU burn ms time).
>At the same time try to build a kernel for example. Then you will realize
>that interactivity is not the bigger problem that the scheduler has right
>now.

I added an irman2 load to contest.  Con's changes 06+06.1 stomped it flat 
[1].  irman2 is modified to run for 30s at a time, but with default parameters.

         -Mike

[1] imho a little too flat.  it also made a worrisome impression on apache 
bench

--=====================_702796==_
Content-Type: text/plain; name="contest.txt";
 x-mac-type="42494E41"; x-mac-creator="74747874"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="contest.txt"

bm9fbG9hZDoKS2VybmVsICAgICAgICAgIFtydW5zXQlUaW1lCUNQVSUJTG9hZHMJTENQVSUJUmF0
aW8KMi41LjY5ICAgICAgICAgICAgICAgMQkxNTMJOTQuOAkwLjAJMC4wCTEuMDAKMi41LjcwICAg
ICAgICAgICAgICAgMQkxNTMJOTQuMQkwLjAJMC4wCTEuMDAKMi42LjAtdGVzdDEgICAgICAgICAg
MQkxNTMJOTQuMQkwLjAJMC4wCTEuMDAKMi42LjAtdGVzdDEtbW0xICAgICAgMQkxNTIJOTQuNwkw
LjAJMC4wCTEuMDAKY2FjaGVydW46Cktlcm5lbCAgICAgICAgICBbcnVuc10JVGltZQlDUFUlCUxv
YWRzCUxDUFUlCVJhdGlvCjIuNS42OSAgICAgICAgICAgICAgIDEJMTQ2CTk4LjYJMC4wCTAuMAkw
Ljk1CjIuNS43MCAgICAgICAgICAgICAgIDEJMTQ2CTk4LjYJMC4wCTAuMAkwLjk1CjIuNi4wLXRl
c3QxICAgICAgICAgIDEJMTQ2CTk4LjYJMC4wCTAuMAkwLjk1CjIuNi4wLXRlc3QxLW1tMSAgICAg
IDEJMTQ2CTk4LjYJMC4wCTAuMAkwLjk2CnByb2Nlc3NfbG9hZDoKS2VybmVsICAgICAgICAgIFty
dW5zXQlUaW1lCUNQVSUJTG9hZHMJTENQVSUJUmF0aW8KMi41LjY5ICAgICAgICAgICAgICAgMQkz
MzEJNDMuOAk5MC4wCTU1LjMJMi4xNgoyLjUuNzAgICAgICAgICAgICAgICAxCTE5OQk3Mi40CTI3
LjAJMjUuNQkxLjMwCjIuNi4wLXRlc3QxICAgICAgICAgIDEJMjY0CTU0LjUJNjEuMAk0NC4zCTEu
NzMKMi42LjAtdGVzdDEtbW0xICAgICAgMQkzMjMJNDQuOQk4OC4wCTU0LjIJMi4xMgpjdGFyX2xv
YWQ6Cktlcm5lbCAgICAgICAgICBbcnVuc10JVGltZQlDUFUlCUxvYWRzCUxDUFUlCVJhdGlvCjIu
NS42OSAgICAgICAgICAgICAgIDEJMTkwCTc3LjkJMC4wCTAuMAkxLjI0CjIuNS43MCAgICAgICAg
ICAgICAgIDEJMTg2CTgwLjEJMC4wCTAuMAkxLjIyCjIuNi4wLXRlc3QxICAgICAgICAgIDEJMjEz
CTcwLjQJMC4wCTAuMAkxLjM5CjIuNi4wLXRlc3QxLW1tMSAgICAgIDEJMjA3CTcyLjUJMC4wCTAu
MAkxLjM2Cnh0YXJfbG9hZDoKS2VybmVsICAgICAgICAgIFtydW5zXQlUaW1lCUNQVSUJTG9hZHMJ
TENQVSUJUmF0aW8KMi41LjY5ICAgICAgICAgICAgICAgMQkxOTYJNzUuMAkwLjAJMy4xCTEuMjgK
Mi41LjcwICAgICAgICAgICAgICAgMQkxOTUJNzUuOQkwLjAJMy4xCTEuMjcKMi42LjAtdGVzdDEg
ICAgICAgICAgMQkxOTMJNzYuNwkxLjAJNC4xCTEuMjYKMi42LjAtdGVzdDEtbW0xICAgICAgMQkx
OTUJNzUuOQkxLjAJNC4xCTEuMjgKaW9fbG9hZDoKS2VybmVsICAgICAgICAgIFtydW5zXQlUaW1l
CUNQVSUJTG9hZHMJTENQVSUJUmF0aW8KMi41LjY5ICAgICAgICAgICAgICAgMQk0MzcJMzQuNgk2
OS4xCTE1LjEJMi44NgoyLjUuNzAgICAgICAgICAgICAgICAxCTQwMQkzNy43CTcyLjMJMTcuNAky
LjYyCjIuNi4wLXRlc3QxICAgICAgICAgIDEJMjQzCTYxLjMJNDguMQkxNy4zCTEuNTkKMi42LjAt
dGVzdDEtbW0xICAgICAgMQkzMzYJNDQuOQk2NC41CTE3LjMJMi4yMQppb19vdGhlcjoKS2VybmVs
ICAgICAgICAgIFtydW5zXQlUaW1lCUNQVSUJTG9hZHMJTENQVSUJUmF0aW8KMi41LjY5ICAgICAg
ICAgICAgICAgMQkzODcJMzguOAk2OS4zCTE3LjMJMi41MwoyLjUuNzAgICAgICAgICAgICAgICAx
CTQyMgkzNi4wCTc1LjMJMTcuMQkyLjc2CjIuNi4wLXRlc3QxICAgICAgICAgIDEJMjU4CTU3LjgJ
NTUuOAkxOS4wCTEuNjkKMi42LjAtdGVzdDEtbW0xICAgICAgMQkzMzAJNDUuNQk2My4yCTE3LjIJ
Mi4xNwpyZWFkX2xvYWQ6Cktlcm5lbCAgICAgICAgICBbcnVuc10JVGltZQlDUFUlCUxvYWRzCUxD
UFUlCVJhdGlvCjIuNS42OSAgICAgICAgICAgICAgIDEJMjIxCTY3LjAJOS40CTMuNgkxLjQ0CjIu
NS43MCAgICAgICAgICAgICAgIDEJMjIwCTY3LjMJOS40CTMuNgkxLjQ0CjIuNi4wLXRlc3QxICAg
ICAgICAgIDEJMjAwCTc0LjAJOS43CTQuMAkxLjMxCjIuNi4wLXRlc3QxLW1tMSAgICAgIDEJMTkw
CTc4LjQJOS4yCTQuMgkxLjI1Cmxpc3RfbG9hZDoKS2VybmVsICAgICAgICAgIFtydW5zXQlUaW1l
CUNQVSUJTG9hZHMJTENQVSUJUmF0aW8KMi41LjY5ICAgICAgICAgICAgICAgMQkyMDMJNzEuNAk5
OS4wCTIwLjIJMS4zMwoyLjUuNzAgICAgICAgICAgICAgICAxCTIwNQk3MC43CTEwNC4wCTIwLjUJ
MS4zNAoyLjYuMC10ZXN0MSAgICAgICAgICAxCTE5OQk3Mi40CTEwMi4wCTIxLjYJMS4zMAoyLjYu
MC10ZXN0MS1tbTEgICAgICAxCTE5Mwk3NS4xCTkxLjAJMTkuNwkxLjI3Cm1lbV9sb2FkOgpLZXJu
ZWwgICAgICAgICAgW3J1bnNdCVRpbWUJQ1BVJQlMb2FkcwlMQ1BVJQlSYXRpbwoyLjUuNjkgICAg
ICAgICAgICAgICAxCTI1Ngk1Ny44CTM0LjAJMS4yCTEuNjcKMi41LjcwICAgICAgICAgICAgICAg
MQkyNTIJNTguNwkzMy4wCTEuMgkxLjY1CjIuNi4wLXRlc3QxICAgICAgICAgIDEJMzA5CTQ4LjIJ
NzUuMAkyLjMJMi4wMgoyLjYuMC10ZXN0MS1tbTEgICAgICAxCTI3Nwk1My44CTM4LjAJMS40CTEu
ODIKZGJlbmNoX2xvYWQ6Cktlcm5lbCAgICAgICAgICBbcnVuc10JVGltZQlDUFUlCUxvYWRzCUxD
UFUlCVJhdGlvCjIuNS42OSAgICAgICAgICAgICAgIDEJNTE3CTI4LjgJNS4wCTM1LjYJMy4zOAoy
LjUuNzAgICAgICAgICAgICAgICAxCTQyNAkzNS4xCTMuMAkyNi43CTIuNzcKMi42LjAtdGVzdDEg
ICAgICAgICAgMQkzNDcJNDIuNwk0LjAJMzkuNQkyLjI3CjIuNi4wLXRlc3QxLW1tMSAgICAgIDEJ
Mzc3CTM5LjgJNC4wCTM2LjkJMi40OAphYl9sb2FkOgpLZXJuZWwgICAgICAgICAgW3J1bnNdCVRp
bWUJQ1BVJQlMb2FkcwlMQ1BVJQlSYXRpbwoyLjUuNjkgICAgICAgICAgICAgICAxCTMwMAk0OC4z
CTQ2LjAJMjEuNwkxLjk2CjIuNS43MCAgICAgICAgICAgICAgIDEJMzAwCTQ4LjAJNDYuMAkyMi4w
CTEuOTYKMi42LjAtdGVzdDEgICAgICAgICAgMQkyODEJNTEuNgk1MC4wCTI1LjYJMS44NAoyLjYu
MC10ZXN0MS1tbTEgICAgICAxCTIyOQk2My4zCTMwLjAJMTguMwkxLjUxCmlybWFuMl9sb2FkOgpL
ZXJuZWwgICAgICAgICAgW3J1bnNdCVRpbWUJQ1BVJQlMb2FkcwlMQ1BVJQlSYXRpbwoyLjYuMC10
ZXN0MSAgICAgICAgICAxCTk5OQkxNC41CTMxLjAJMC4wCTYuNTMKMi42LjAtdGVzdDEtbW0xICAg
ICAgMQkyMTAJNjkuMAk2LjAJMC4wCTEuMzgK
--=====================_702796==_--

