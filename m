Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWAWSrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWAWSrT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 13:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWAWSrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 13:47:19 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:33203 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964881AbWAWSrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 13:47:18 -0500
Date: Mon, 23 Jan 2006 10:47:14 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm2
In-Reply-To: <20060123184157.GA11148@sergelap.austin.ibm.com>
Message-ID: <Pine.LNX.4.62.0601231046590.31765@schroedinger.engr.sgi.com>
References: <20060120031555.7b6d65b7.akpm@osdl.org>
 <20060123184157.GA11148@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2006, Serge E. Hallyn wrote:

> I don't understand why this wouldn't die on every architecture,
> since node_to_cpumask is an inline function.

Its an array lookup on ia64.
