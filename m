Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVC3F74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVC3F74 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 00:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVC3F74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 00:59:56 -0500
Received: from ozlabs.org ([203.10.76.45]:14772 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261568AbVC3F6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 00:58:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16970.16535.864623.323556@cargo.ozlabs.ibm.com>
Date: Wed, 30 Mar 2005 16:00:55 +1000
From: Paul Mackerras <paulus@samba.org>
To: Antonio Vargas <windenntw@gmail.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
Subject: Re: prefetch on ppc64
In-Reply-To: <69304d110503292138620d4587@mail.gmail.com>
References: <20050330034034.GA1752@IBM-BWN8ZTBWA01.austin.ibm.com>
	<16970.9005.721117.942549@cargo.ozlabs.ibm.com>
	<69304d110503292138620d4587@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonio Vargas writes:

> Don't know exactly about power5, but G5 processor is described on IBM
> docs as doing automatic whole-page prefetch read-ahead when detecting
> linear accesses.

Sure, but linked lists would rarely be laid out linearly in memory.

Paul.
