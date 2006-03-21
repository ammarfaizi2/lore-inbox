Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWCUHPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWCUHPf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 02:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWCUHPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 02:15:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:14804 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932287AbWCUHPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 02:15:34 -0500
Subject: Re: [GIT PATCH] Remove devfs from 2.6.16
From: Arjan van de Ven <arjan@infradead.org>
To: Olivier Galibert <galibert@pobox.com>
Cc: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       davej@redhat.com
In-Reply-To: <20060320235846.GA84147@dspnet.fr.eu.org>
References: <20060320212338.GA11571@kroah.com>
	 <20060320235846.GA84147@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 08:15:22 +0100
Message-Id: <1142925322.3077.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 00:58 +0100, Olivier Galibert wrote:
> On Mon, Mar 20, 2006 at 01:23:38PM -0800, Greg KH wrote:
> > They are the same "delete devfs" patches that I submitted for 2.6.12 and
> > 2.6.13 and 2.6.14 and 2.6.15.  It rips out all of devfs from the kernel
> > and ends up saving a lot of space.  Since 2.6.13 came out, I have seen
> > no complaints about the fact that devfs was not able to be enabled
> > anymore, and in fact, a lot of different subsystems have already been
> > deleting devfs support for a while now, with apparently no complaints
> > (due to the lack of users.)
> 
> I'm an occasional user.  I'm just able to add a config entry by hand.
> 
> Devfs for block devices is required for the fedora core 3 install
> kernel.  

that is not true; Fedora Core 3 does not even have devfs enabled, and
neither RHL nor FC has shipped devfsd like forever

FC3 uses udev


