Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261433AbSIZSbm>; Thu, 26 Sep 2002 14:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261434AbSIZSbm>; Thu, 26 Sep 2002 14:31:42 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:26130 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S261433AbSIZSbl>; Thu, 26 Sep 2002 14:31:41 -0400
Date: Thu, 26 Sep 2002 20:36:53 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Ernst Herzberg <earny@net4u.de>
cc: Adam Goldstein <Whitewlf@Whitewlf.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Very High Load, kernel 2.4.18, apache/mysql
In-Reply-To: <200209260503.02474.earny@net4u.de>
Message-ID: <Pine.LNX.4.44.0209262035060.26363-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, Ernst Herzberg wrote:

> First reconfigure your apache, with
> 
> MaxClients 256  # absolute minimum, maybe you have to recompile apache
> MinSpareServers 100  # better 150 to 200
> MaxSpareServers 200 # bring it near MaxClients

KeepAlive		On
MaxKeepAliveRequests	1000

.TM.

