Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUCGMVd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 07:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbUCGMVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 07:21:33 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:63104 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S261865AbUCGMVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 07:21:32 -0500
Date: Sun, 07 Mar 2004 20:21:03 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Lawrence Walton" <lawrence@the-penguin.otak.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: server migration
References: <20040305181322.GA32114@the-penguin.otak.com> <200403070133.07784.vda@port.imtp.ilyichevsk.odessa.ua> <20040307013507.GB13908@the-penguin.otak.com> <200403071231.50912.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr4hq9dmf4evsfm@smtp.pacific.net.th>
In-Reply-To: <200403071231.50912.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > On Friday 05 March 2004 20:13, Lawrence Walton wrote:
>> > > Hi all!
>> > >
>> > > I tried about four months ago to migrate a busy server to 2.6.0-test9,
>> > > and failed miserably. Lightly loaded it worked well but as the number
>> > > of users increased, the number of processes in uninterruptible sleep
>> > > increased to the hundreds and then the server fell on it's face. I
>> > > never found out exactly why or what processes where hanging if I
>> > > guessed it would be openldap.

-Test9 was the "oddest" kernel I ever ran (since 2.2.x) - even got it
repeatably to hardlock lock by loading it a bit with dd ;)

Since then, Nick Pigin has put a hell of an effort into the
anticipatory scheduler and much else all over has been refined too.

I have done a bit of stress testing of io, network and cpu and
IMO, 2.6.3 will perform nicely in a server environment and there
will be no significant problems.

Input from production use is essential though and it would be much
appreciated if you would go for it :)

Regards
Michael



