Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbVKOSjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbVKOSjj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 13:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbVKOSjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 13:39:39 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:9165 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964852AbVKOSji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 13:39:38 -0500
Date: Tue, 15 Nov 2005 10:39:27 -0800
From: Paul Jackson <pj@sgi.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org, haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-Id: <20051115103927.2ca4bffb.pj@sgi.com>
In-Reply-To: <4379F29D.3090306@watson.ibm.com>
References: <20051114212341.724084000@sergelap>
	<20051114153649.75e265e7.pj@sgi.com>
	<20051115010155.GA3792@IBM-BWN8ZTBWAO1>
	<20051114175140.06c5493a.pj@sgi.com>
	<20051115022931.GB6343@sergelap.austin.ibm.com>
	<20051114193715.1dd80786.pj@sgi.com>
	<20051115051501.GA3252@IBM-BWN8ZTBWAO1>
	<20051114223513.3145db39.pj@sgi.com>
	<20051115081100.GA2488@IBM-BWN8ZTBWAO1>
	<20051115010624.2ca9237d.pj@sgi.com>
	<20051115133222.GA2232@IBM-BWN8ZTBWAO1>
	<4379F29D.3090306@watson.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think that the checkpoint/restart/relocation design should be
driven by mico-optimizations of getpid().  It needs to be driven by
a design that addresses (for better or worse) the many larger questions
encountered in such an effort.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
