Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161088AbWGITsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbWGITsq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 15:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161089AbWGITsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 15:48:46 -0400
Received: from mail.polish-dvd.com ([69.222.0.225]:10149 "HELO
	mail.webhostingstar.com") by vger.kernel.org with SMTP
	id S1161088AbWGITsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 15:48:46 -0400
Message-ID: <20060709193434.4645.qmail@mail.webhostingstar.com>
From: "art" <art@usfltd.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc1-git1-64-smp cpu freq ondemand governor problem
Date: Sun, 09 Jul 2006 14:34:34 -0500
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.18-rc1-git1-64-smp cpu freq ondemand governor problem 

on dual core amd 64bit system 

 - start 2 proceses with infinite loop in each - OK both cores 100% 
utilization cpu speed max
 - kill one - BAD now one core utilization 90-100% but cpu speed fluctuating 
from min to max depending on system activity 

any posibility to setup ondemand governor for max speed if only 1 processor 
utilization is maxed - full speed for single process/thread activity ? 

xboom 

art@usfltd.com
