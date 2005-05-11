Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVEKX6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVEKX6o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 19:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVEKX6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 19:58:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62105 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261334AbVEKX6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 19:58:41 -0400
Date: Wed, 11 May 2005 19:58:31 -0400
From: Dave Jones <davej@redhat.com>
To: Erik Mckee <emckee@cs.tamu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FC3 oops
Message-ID: <20050511235830.GA10725@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Erik Mckee <emckee@cs.tamu.edu>, linux-kernel@vger.kernel.org
References: <Pine.GSO.4.58.0505111847430.28589@sun>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0505111847430.28589@sun>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 06:53:21PM -0500, Erik Mckee wrote:
 > I got the following complaints on my macine.  It is Intel, 3.6 GHz
 > hyperthreaded processor with SATA software RAID.  Any idea what the
 > problem is?  It looks like USB is involved, as I was attaching my iPOD at
 > the time via USB

Fixed in the updates-testing kernel.  This blew up for lots of Fedora
users as CFQ is the default there. As CFQ isnt the default upstream
it wasn't deemed important enough for 2.6.11.x
It's fixed in .12rc though.

		Dave

