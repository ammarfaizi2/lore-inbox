Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266566AbUHBPer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266566AbUHBPer (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 11:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266567AbUHBPer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 11:34:47 -0400
Received: from scrye.com ([216.17.180.1]:9936 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S266566AbUHBPem convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 11:34:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown
Content-Transfer-Encoding: 8BIT
Date: Mon, 2 Aug 2004 09:34:35 -0600
From: Kevin Fenzi <kevin-kernel@scrye.com>
To: linux-kernel@vger.kernel.org
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Subject: Re: swsusp in 2.6.8-rc2-mm1
X-Draft-From: ("scrye.linux.kernel" 53702)
References: <20040729232204.GA8020@chepelov.org>
	<Pine.LNX.4.50.0408012320500.4359-100000@monsoon.he.net>
	<20040802075534.GA22537@chepelov.org>
Message-Id: <20040802153438.DFA58D5051@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Cyrille" == Cyrille Chepelov <cyrille@chepelov.org> writes:

Cyrille> Le Sun, Aug 01, 2004, -bÃ  11:22:04PM -0700, Patrick Mochel a-A
Cyrille> -bécrit:-A
>> On Fri, 30 Jul 2004, Cyrille Chepelov wrote:

>> > Long story made short, it seems that the new swsusp code felt
>> like > dereferencing a NULL, and I thought you'd might want to know
>> about that.  > I know it's pretty bad form to send an oops in a
>> photographic way, but > that's better than nothing and I hope
>> you'll be able to exploit this.
>> >
>> > I've put the stuff at http://www.chepelov.org/cyrille/swsusp
>> 
>> It's better than nothing, but would please post to the list next
>> time.  That way other people with similar problems may be able to
>> help, too.
>> 
>> Hrm, I can't seem to connect..will look into it later..

Cyrille> OK, sorry about that. My 486 router/web server is dying, and
Cyrille> I've got some heavy reformatting/replacement action pending
Cyrille> next week. Here's an alternative address for now:
Cyrille> http://perso.crans.org/~chepelov/swsusp/

I see you have preempt enabled. 

Can you try compiling without preempt and see if the problem occurs
again?

kevin

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFBDl8O3imCezTjY0ERAqeOAJ9WdXDCols5/fT//dnuDSyXVoVaBgCfWREd
bA0DdtNBggdFNE6trZSFMv8Jgs
-----END PGP SIGNATURE-----
