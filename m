Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267398AbTAGPmq>; Tue, 7 Jan 2003 10:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267401AbTAGPmq>; Tue, 7 Jan 2003 10:42:46 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:52871
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267398AbTAGPmq>; Tue, 7 Jan 2003 10:42:46 -0500
Subject: Re: PATCH: fix "ide_scan_direction defined but not used" in ide.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030107131002.GI25540@alhambra>
References: <20030107131002.GI25540@alhambra>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041957377.20658.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 07 Jan 2003 16:36:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-07 at 13:10, Muli Ben-Yehuda wrote:
> ide_scan_drection is only used if CONFIG_BLK_DEV_IDEPCI is defined,
> giving a compilation warning otherwise. Against 2.5.54-bk. 

Please reject. This is uglier than the warning and not the right approach

