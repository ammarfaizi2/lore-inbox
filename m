Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbULJVa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbULJVa7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 16:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbULJV3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 16:29:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43190 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261790AbULJV24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 16:28:56 -0500
Date: Fri, 10 Dec 2004 16:28:31 -0500
From: Dave Jones <davej@redhat.com>
To: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XGI Volari XP5 PCI device ID
Message-ID: <20041210212831.GB6648@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>,
	linux-kernel@vger.kernel.org
References: <41BA0B77.9000902@mech.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BA0B77.9000902@mech.kuleuven.ac.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 09:47:51PM +0100, Panagiotis Issaris wrote:
 
 > Some Dell Inspiron 5160s are now shipped with a
 > XGI Volari XP5. The card's PCI vendor identifier
 > is 1023, which represents Trident. XGI bought Trident
 > in june 2003.
 > 
 > This trivial patch adds the PCI device ID to the database.

The correct way is to add it to the database at http://pciids.sf.net
which gets periodically synced with the kernel.
This way, your addition automatically finds its way
into pciutils and any other userspace tools using that database.

		Dave

