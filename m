Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263850AbUEXXaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUEXXaP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 19:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbUEXXaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 19:30:15 -0400
Received: from CPE-61-9-212-151.qld.bigpond.net.au ([61.9.212.151]:26162 "EHLO
	youngs.au.com") by vger.kernel.org with ESMTP id S263850AbUEXXaL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 19:30:11 -0400
Mail-Copies-To: never
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: "Laughlin, Joseph V" <Joseph.V.Laughlin@boeing.com>
Subject: Re: Modifying kernel so that non-root users have some root
 capabilities
References: <67B3A7DA6591BE439001F2736233351202B47E6F@xch-nw-28.nw.nos.boeing.com>
From: Steve Youngs <steve@youngs.au.com>
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Organization: Linux Users - Fanatics Dept.
X-X-Day: Only 2431461 days till X-Day.  Got Slack?
X-URL: <http://users.bigpond.net.au/sryoungs/>
X-Request-PGP: <http://users.bigpond.net.au/sryoungs/pgp/sryoungs.asc>
X-OpenPGP-Fingerprint: 1659 2093 19D5 C06E D320  3A20 1D27 DB4B A94B 3003
X-Discordian-Date: Setting Orange, the 72nd day of Discord, 3170. 
X-Attribution: SY
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
 "Laughlin, Joseph V" <Joseph.V.Laughlin@boeing.com>
Date: Tue, 25 May 2004 09:24:17 +1000
In-Reply-To: <67B3A7DA6591BE439001F2736233351202B47E6F@xch-nw-28.nw.nos.boeing.com>
 (Joseph V. Laughlin's message of "Mon, 24 May 2004 15:21:56 -0700")
Message-ID: <microsoft-free.8765alo1cu.fsf@youngs.au.com>
User-Agent: Gnus/5.110003 (No Gnus v0.3) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Joseph V Laughlin <Laughlin> writes:

  > I've been tasked with modifying a 2.4 kernel so that a non-root user can
  > do the following:

  > Dynamically change the priorities of processes (up and down)
  > Lock processes in memory
  > Can change process cpu affinity

I'm assuming that there are user-land tools to do these things now for
root, right?  So why not look into things like sudo(8) or even setuid
executables? 


-- 
|---<Steve Youngs>---------------<GnuPG KeyID: A94B3003>---|
|              Ashes to ashes, dust to dust.               |
|      The proof of the pudding, is under the crust.       |
|----------------------------------<steve@youngs.au.com>---|
