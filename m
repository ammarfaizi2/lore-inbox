Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWCZXKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWCZXKH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 18:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWCZXKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 18:10:06 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:55464 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932177AbWCZXKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 18:10:05 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44271F22.6080400@s5r6.in-berlin.de>
Date: Mon, 27 Mar 2006 01:09:22 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Bodo Eggert <7eggert@gmx.de>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] Move SG_GET_SCSI_ID from sg to scsi
References: <Pine.LNX.4.58.0603262108500.13001@be1.lrz>
In-Reply-To: <Pine.LNX.4.58.0603262108500.13001@be1.lrz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.807) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:
> Having a SCSI ID is a generic SCSI property,

Most types of SCSI hardware do not have h:c:i:l style IDs like in the 
80's. The lower level drivers only make this tuple up to accomodate 
programming interfaces.
-- 
Stefan Richter
-=====-=-==- --== ==-==
http://arcgraph.de/sr/
