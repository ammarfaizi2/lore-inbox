Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWBBUI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWBBUI0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 15:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWBBUI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 15:08:26 -0500
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:53735 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S932201AbWBBUI0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 15:08:26 -0500
Message-ID: <43E266AD.4020203@fr.ibm.com>
Date: Thu, 02 Feb 2006 21:08:13 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: Kirill Korotaev <dev@openvz.org>, serue@us.ibm.com, arjan@infradead.org,
       frankeh@watson.ibm.com, haveblue@us.ibm.com, mrmacman_g4@mac.com,
       alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, devel@openvz.org
Subject: Re: [RFC][PATCH 3/7] VPIDs: fork modifications
References: <43E22B2D.1040607@openvz.org> <43E23229.5070503@sw.ru>
In-Reply-To: <43E23229.5070503@sw.ru>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:

> This patch changes forking procedure. Basically it adds a function
> do_fork_pid() that alows forking task with predefined virtual pid.
> Also it adds required vpid manipulations on fork().
> Simple and straightforward.

I'd like to see what goes behind that patch, specially if it is used to
restart a process tree. Is it in openvz yet ?

c.
