Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263686AbTDTTep (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 15:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263687AbTDTTep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 15:34:45 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:54740
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263686AbTDTTeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 15:34:44 -0400
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: John Bradford <john@grabjohn.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030420192110.1a457c2d.skraw@ithnet.com>
References: <20030420185512.763df745.skraw@ithnet.com>
	 <200304201712.h3KHCsBu000709@81-2-122-30.bradfords.org.uk>
	 <20030420192110.1a457c2d.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050864521.11658.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 20 Apr 2003 19:48:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-04-20 at 18:21, Stephan von Krawczynski wrote:
> I know you favor a layer between low-level driver and fs probably. Sure it is
> clean design, and sure it sounds like overhead (Yet Another Layer).

Wrong again - its actually irrelevant to the cost of mirroring data, the cost
is entirely in the PCI and memory bandwidth. The raid1 management overhead is
almost nil

