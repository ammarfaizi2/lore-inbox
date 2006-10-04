Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030752AbWJDIW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030752AbWJDIW2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 04:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030754AbWJDIW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 04:22:28 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:27843 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1030753AbWJDIW1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 04:22:27 -0400
Subject: Re: debugfs oddity
From: Johannes Berg <johannes@sipsolutions.net>
To: Greg KH <gregkh@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Joel Becker <Joel.Becker@oracle.com>, Michael Buesch <mb@bu3sch.de>
In-Reply-To: <20061004081213.GA3477@suse.de>
References: <1159781104.2655.47.camel@ux156>
	 <20061003052839.GA18989@suse.de> <1159946446.2817.2.camel@ux156>
	 <20061004081213.GA3477@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Oct 2006 10:23:19 +0200
Message-Id: <1159950200.2817.34.camel@ux156>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92 
X-sips-origin: local
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-04 at 01:12 -0700, Greg KH wrote:

> I don't understand.  Does ramfs have the same issues you feel debugfs
> has?  Or does it work like a disk based file system?

It works like tmpfs and disk based filesystems and allows re-creating a
removed directory.

johannes
