Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264591AbTK3AjO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 19:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264592AbTK3AjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 19:39:13 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:10508 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264591AbTK3AjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 19:39:11 -0500
Date: Sun, 30 Nov 2003 01:39:04 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: John Bradford <john@grabjohn.com>, Szakacsits Szabolcs <szaka@sienet.hu>,
       Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031130003904.GB5465@win.tue.nl>
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl> <20031129022221.GA516@gnu.org> <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi> <20031129123451.GA5372@win.tue.nl> <200311291350.hATDo0CY001142@81-2-122-30.bradfords.org.uk> <20031129170103.GA6092@iliana> <20031129221424.GA5456@win.tue.nl> <20031129224411.GA9214@iliana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031129224411.GA9214@iliana>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 29, 2003 at 11:44:11PM +0100, Sven Luther wrote:

> That said, i really doubt that a standard BIOS can boot from a not MBR
> containing disk, but i may be wrong.

The BIOS reads the MBR and jumps to the code loaded from there.
There is no need for any partition table, or, if there is a table,
for any particular format. It is all up to the code that is found
in the MBR.

