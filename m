Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbUCFLrh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 06:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbUCFLrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 06:47:37 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:36524 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261657AbUCFLrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 06:47:36 -0500
From: Frank.A.Uepping@t-online.de (Frank A. Uepping)
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: struct device::release issue
Date: Sat, 6 Mar 2004 12:47:24 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403061247.24251.Frank.A.Uepping@t-online.de>
X-Seen: false
X-ID: TtRKgBZJYeIKnwq5SJSD1Ayw4d3wbpo9NOBF5qB9uueMd6Bjd+5c06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
if device_add fails (e.g. bus_add_device returns an error) then the release 
method will be called for the device. Is this a bug or a feature?

/FAU
