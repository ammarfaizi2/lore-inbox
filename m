Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbUKWVyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbUKWVyy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 16:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUKWVng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 16:43:36 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:17280 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S261417AbUKWVnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 16:43:23 -0500
Date: Tue, 23 Nov 2004 21:43:20 +0000
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: bug in man netdevice?
Message-ID: <20041123214320.GA2193@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

struct ifreq {
           char    ifr_name[IFNAMSIZ];/* Interface name */
           union {
                   struct sockaddrifr_addr;
                   struct sockaddrifr_dstaddr;
                   struct sockaddrifr_broadaddr;
                   struct sockaddrifr_netmask;
                   struct sockaddrifr_hwaddr;

This looks like spaces forgotten between "sockaddr" and ifr_something.
Is it a bug? Or is it some elaborate language construct?

Cl<
