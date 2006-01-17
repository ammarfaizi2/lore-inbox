Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWAQQTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWAQQTZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 11:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWAQQTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 11:19:25 -0500
Received: from elvis.mu.org ([192.203.228.196]:51702 "EHLO elvis.mu.org")
	by vger.kernel.org with ESMTP id S932104AbWAQQTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 11:19:24 -0500
Message-ID: <43CD18FF.4070006@FreeBSD.org>
Date: Tue, 17 Jan 2006 08:19:11 -0800
From: Suleiman Souhlal <ssouhlal@FreeBSD.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Serge Hallyn <serue@us.ibm.com>
CC: linux-kernel@vger.kernel.org, Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: RFC [patch 00/34] PID Virtualization Overview
References: <20060117143258.150807000@sergelap>
In-Reply-To: <20060117143258.150807000@sergelap>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge Hallyn wrote:

> The mechanism to start a container 
> is to 'echo "container_name" > /proc/container'  which creates a new
> container and associates the calling process with it. All subsequently
> forked tasks then belong to that container.
> There is a separate pid space associated with each container.
> Only processes/task belonging to the same container "see" each other.

Why does there need a separate pid space for each container?
You don't really need one to make sure that only processes in the same 
containers can see each other.

-- Suleiman
