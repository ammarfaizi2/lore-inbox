Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265173AbUBJUNz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 15:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265535AbUBJUME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 15:12:04 -0500
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:12526 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S265620AbUBJULq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 15:11:46 -0500
Message-ID: <40293AF8.1080603@backtobasicsmgmt.com>
Date: Tue, 10 Feb 2004 13:11:36 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca> <40291A73.7050503@nortelnetworks.com> <20040210192456.GB4814@tinyvaio.nome.ca> <40293508.1040803@nortelnetworks.com>
In-Reply-To: <40293508.1040803@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:

> Don't you have to explicitly mount /dev as type devfs?  How is this 
> different than mounting it as tmpfs?

devfs is "single-instance": it can be mounted during initrd/initramfs 
processing, then remounted after pivot_root without losing its contents

Granted, I'm sure someone can come up with a single-instance ramfs 
filesystem that can be used for udev, but today it does not exist.


