Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUFBMWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUFBMWD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 08:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUFBMVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 08:21:12 -0400
Received: from main.gmane.org ([80.91.224.249]:9385 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262065AbUFBMUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 08:20:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: How come dd if=/dev/zero of=/nfs/dev/null does not send packets
 over the network?
Date: Wed, 02 Jun 2004 14:20:12 +0200
Message-ID: <yw1xaczmw3r7.fsf@kth.se>
References: <5D3C2276FD64424297729EB733ED1F7606243695@email1.mitretek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:HSjjaM8w6cTNqfYkQsKiX6EFr60=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Piszcz, Justin Michael" <justin.piszcz@mitretek.org> writes:

> root@jpiszcz:~# mkdir /p500/dev
> root@jpiszcz:~# mount 192.168.0.253:/dev /p500/dev
> root@jpiszcz:~# echo blah > /p500/dev/null
> root@jpiszcz:~# ls -l /p500/dev/null
> crw-rw-rw-  1 root sys 1, 3 Jul 17  1994 /p500/dev/null
> root@jpiszcz:~# dd if=/dev/zero of=/p500/dev/null
>
> 6179737+0 records in
> 6179736+0 records out
>
> Instead it treats it as a local block device?
>
> Kernel 2.6.5.

That is how it's supposed to work.  Think about root on nfs.

-- 
Måns Rullgård
mru@kth.se

