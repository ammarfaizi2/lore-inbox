Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWAISUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWAISUL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbWAISUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:20:11 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:17802 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964904AbWAISUK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:20:10 -0500
Subject: Re: [patch 1/2] add __meminit for memory hotplug
From: Dave Hansen <haveblue@us.ibm.com>
To: Matt Tolentino <metolent@cs.vt.edu>
Cc: ak@suse.de, akpm@osdl.org, discuss@x86-64.org, kmannth@us.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <200601091519.k09FJUi3022305@ap1.cs.vt.edu>
References: <200601091519.k09FJUi3022305@ap1.cs.vt.edu>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 10:20:08 -0800
Message-Id: <1136830808.17903.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 10:19 -0500, Matt Tolentino wrote:
> Add __meminit to the __init lineup to ensure functions default
> to __init when memory hotplug is not enabled.  Replace __devinit
> with __meminit on functions that were changed when the memory
> hotplug code was introduced.  

Ack.  Looks good.  There was a time when people didn't want __YYYYinit,
but we might as well use one while they're proliferating.

-- Dave

