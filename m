Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264375AbTK2W10 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 17:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264438AbTK2W10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 17:27:26 -0500
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:44928 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S264375AbTK2W1Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 17:27:25 -0500
Message-ID: <3FC91D22.8030404@rackable.com>
Date: Sat, 29 Nov 2003 14:26:42 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@hera.kernel.org>
CC: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: libata in 2.4.24?
References: <200311281827.hASIRmPe022656@hera.kernel.org>
In-Reply-To: <200311281827.hASIRmPe022656@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Nov 2003 22:27:19.0967 (UTC) FILETIME=[F3B04AF0:01C3B6C7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Are you considering including libata support for 2.4.24?  From my 
testing with a number of different embedded sata chipsets (mostly ICH, 
SI, and Promise) it appears very stable.  I'm not seeing any data 
corruption or lockups when running Cerberus with 2.4.23-rc5 + libata 
patch.  The only troubles I've had were with initialization of embedded 
promise sata controllers. (I still need to test with Jeff's latest fixes 
for this.)


-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

