Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267287AbUHPAL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267287AbUHPAL3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 20:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267294AbUHPAL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 20:11:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27044 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267287AbUHPAL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 20:11:27 -0400
Date: Sun, 15 Aug 2004 20:11:10 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: romieu@fr.zoreil.com, <sds@epoch.ncsc.mil>, <neilb@cse.unsw.edu.au>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][LIBFS] Move transaction file ops into libfs + cleanup
 (update)
In-Reply-To: <Xine.LNX.4.44.0408151943290.1966-100000@dhcp83-76.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0408152010510.1966-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Aug 2004, James Morris wrote:

> Yes, this is SMP specific.  i.e. thread A is writing to ar->data and 
> thread B wants to know if ar->data is non-zero to read it.
                                ^^^^  should be 'size'


- James
-- 
James Morris
<jmorris@redhat.com>


