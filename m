Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUBJUji (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 15:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266161AbUBJUji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 15:39:38 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:42130 "EHLO
	ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S266136AbUBJUjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 15:39:37 -0500
Date: Tue, 10 Feb 2004 15:39:00 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040210203900.GA18263@ti19.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	"Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
	linux-kernel@vger.kernel.org
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca> <40291A73.7050503@nortelnetworks.com> <20040210192456.GB4814@tinyvaio.nome.ca> <40293508.1040803@nortelnetworks.com> <40293AF8.1080603@backtobasicsmgmt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40293AF8.1080603@backtobasicsmgmt.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 01:11:36PM -0700, Kevin P. Fleming wrote:
> devfs is "single-instance": it can be mounted during initrd/initramfs 
> processing, then remounted after pivot_root without losing its contents
> 
> Granted, I'm sure someone can come up with a single-instance ramfs 
> filesystem that can be used for udev, but today it does not exist.
 
mount --move olddir newdir

Regards,

	Bill Rugolsky
