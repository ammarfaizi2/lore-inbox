Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVBVSW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVBVSW3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 13:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVBVSW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 13:22:29 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:65169 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261272AbVBVSWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 13:22:21 -0500
Subject: Re: JFFS2 Extended attributes support & SELinux in handhelds
From: Josh Boyer <jdub@us.ibm.com>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: familiar-dev@handhelds.org, selinux@tycho.nsa.gov,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       familiar@handhelds.org, handhelds@handhelds.org,
       kernel-discuss@handhelds.org, oe@handhelds.org, agruen@suse.de,
       Russell Coker <rcoker@redhat.com>
In-Reply-To: <1109089039.4100.114.camel@localhost.localdomain>
References: <1109089039.4100.114.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 22 Feb 2005 12:21:42 -0600
Message-Id: <1109096502.7813.5.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-22 at 17:17 +0100, Lorenzo Hernández García-Hierro
wrote:
> Hi,
> 
> I've been working in implementing extended attributes support in the
> JFFS2 filesystem.

You should send this to the JFFS2 development list.  The xattr support
is probably a JFFS3 candidate.

> 
> The current work is just a draft, I've started with the standard Vanilla
> kernel sources plus mtd JFFS2 sources, used to patch the vanilla ones
> for latest code (I'm confused on which one has the most updated tree or
> if there are special differences between mtd's trees and vanilla's), and
> implemented the skeleton using the reiserfs xattr code base.

The mtd tree is the most current.  Any development would probably get
the most benefit from being done there.  Especially since JFFS3 doesn't
exist anywhere else :).

> In addition, having someone experienced with xattr API could be great,
> as development documentation seems inexistent, among James Morris'
> merged xattr consolidation code.

There have been some xattr proposals discussed on the MTD and JFFS2
mailing lists.  They might be a starting place for you.

josh

