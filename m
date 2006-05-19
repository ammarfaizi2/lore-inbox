Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWESUSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWESUSl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 16:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWESUSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 16:18:41 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:3749 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964811AbWESUSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 16:18:40 -0400
Subject: Re: [PATCH 0/9] namespaces: Introduction
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, herbert@13thfloor.at,
       serue@us.ibm.com, linux-kernel@vger.kernel.org, dev@sw.ru,
       devel@openvz.org, sam@vilain.net, xemul@sw.ru, clg@fr.ibm.com,
       Daniel Lezcano <dlezcano@fr.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
In-Reply-To: <20060519094047.425dced1.akpm@osdl.org>
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
	 <20060518103430.080e3523.akpm@osdl.org>
	 <20060519124235.GA32304@MAIL.13thfloor.at>
	 <20060519081334.06ce452d.akpm@osdl.org>
	 <m1iro2yo7f.fsf@ebiederm.dsl.xmission.com>
	 <20060519094047.425dced1.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 19 May 2006 13:17:12 -0700
Message-Id: <1148069832.6623.209.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-19 at 09:40 -0700, Andrew Morton wrote:
> Migration of currently-open sockets (for example) would require storing of
> a lot of state, wouldn't it?

In a word, yes. :)

I don't think the networking guys from either the OpenVZ project or IBM
were cc'd on this.  Alexey, Daniel, can you elaborate, or point us to
any existing code?

-- Dave

