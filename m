Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263578AbVCEEez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbVCEEez (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 23:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263410AbVCDXmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:42:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35266 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263276AbVCDVuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:50:54 -0500
Date: Fri, 4 Mar 2005 16:50:33 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, chrisw@osdl.org,
       torvalds@osdl.org
Subject: Re: Linux 2.6.11.1
Message-ID: <20050304215033.GB931@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, chrisw@osdl.org, torvalds@osdl.org
References: <20050304175302.GA29289@kroah.com> <20050304124431.676fd7cf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304124431.676fd7cf.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 12:44:31PM -0800, Andrew Morton wrote:

 > wrt the nfsd patches, Neil said:
 > 
 > The problem they fix is that currently:
 >     Client A holds a lock
 >     Client B tries to get the lock and blocks
 >     Client A drops the lock
 >   **Client B doesn't get the lock immediately, but has to wait for a
 >            timeout. (several seconds)

Sounds like a performance thing than "oh my god the world is falling apart"
type thing.  Given it recovers after a few seconds, is it worth it ?

		Dave

