Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWFTVWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWFTVWP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWFTVWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:22:14 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:26193 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751115AbWFTVVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:21:48 -0400
Message-ID: <449866E7.4050508@fr.ibm.com>
Date: Tue, 20 Jun 2006 23:21:43 +0200
From: Daniel Lezcano <dlezcano@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com
Subject: Re: [RFC] [patch 0/6] [Network namespace] introduction
References: <20060609210202.215291000@localhost.localdomain> <20060618184734.GB27946@ftp.linux.org.uk>
In-Reply-To: <20060618184734.GB27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Fri, Jun 09, 2006 at 11:02:02PM +0200, dlezcano@fr.ibm.com wrote:
> - renaming an interface in one "namespace" affects everyone.

Exact. If we ensure the interface can't be renamed if used in different 
namespace, is it really a problem ?

