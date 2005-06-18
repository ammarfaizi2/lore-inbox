Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVFRQEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVFRQEk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 12:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVFRQEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 12:04:40 -0400
Received: from 212-28-208-94.customer.telia.com ([212.28.208.94]:16648 "EHLO
	www.dewire.com") by vger.kernel.org with ESMTP id S262145AbVFRQEi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 12:04:38 -0400
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Date: Sat, 18 Jun 2005 18:04:20 +0200
User-Agent: KMail/1.8.1
Cc: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Patrick McFarland <pmcfarland@downeast.net>,
       "Richard B. Johnson" <linux-os@analogic.com>,
       Lukasz Stelmach <stlman@poczta.fm>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>
References: <yw1xslzl8g1q.fsf@ford.inprovide.com> <20050617130914.GB23488@csclub.uwaterloo.ca> <yw1xy899unga.fsf@ford.inprovide.com>
In-Reply-To: <yw1xy899unga.fsf@ford.inprovide.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506181804.21366.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fredagen den 17 juni 2005 15.23 skrev Måns Rullgård:
> Some characters can be encoded in several equally shortest ways.  

No they cannot. How to encode characters i explicitly and well defined. If you 
don't follow the rules you are simply not producing UTF-8, but something 
else.

Every unicode character has exactly one  UTF-8 representation. 

-- robin

