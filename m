Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTKCRmz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 12:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbTKCRmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 12:42:55 -0500
Received: from main.gmane.org ([80.91.224.249]:7573 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262063AbTKCRmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 12:42:54 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: NFS on 2.6.0-test9
Date: Mon, 03 Nov 2003 18:42:51 +0100
Message-ID: <yw1xbrrtpcv8.fsf@kth.se>
References: <NN6j.pY.25@gated-at.bofh.it> <NPhU.42k.19@gated-at.bofh.it>
 <3FA68CD1.80608@driscollnewsletter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:j6Rv/FuxFHTsZZ0nwPF0+Ulo1Vw=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Driscoll <news.cis@driscollnewsletter.com> writes:

>>>On a kernel 2.6.0-test9 as an NFS client I am having trouble transferring
>>>data to and from NFS servers. It it extraordinarily slow.  I receive the
>>>following information in dmesg:
>>>
>>>nfs warning: mount version older than kernel
>> I see that one, too.  Apart from that, it appears to work.  Try the
>> tcp option, and see if it helps.
>>
> tcp option seems to have helped, except when attempting to mount a
> redhat 9 nfs server.  Mount says:
> "nfs server reported service unavailable: Address already in use"

Maybe the NFS server in RH9 doesn't support TCP mounts.  I just spent
the better part of the afternoon fighting with almost every other
aspect of an RH9 system, so nothing surprises me when it comes to
redhat.  They even ship a broken perl.

-- 
Måns Rullgård
mru@kth.se

