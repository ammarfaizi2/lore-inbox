Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWCVInU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWCVInU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 03:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWCVInU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 03:43:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46274 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751109AbWCVInS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 03:43:18 -0500
Subject: Re: [RFC PATCH 29/35] Add the Xen virtual console driver.
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
In-Reply-To: <20060322063804.956561000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
	 <20060322063804.956561000@sorel.sous-sol.org>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 09:43:16 +0100
Message-Id: <1143016996.2955.24.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 22:31 -0800, Chris Wright wrote:
> plain text document attachment (28-xen-console)
> This provides a bootstrap and ongoing emergency console which is
> intended to be available from very early during boot and at all times
> thereafter, in contrast with alternatives such as UDP-based syslogd,
> or logging in via ssh. The protocol is based on a simple shared-memory
> ring buffer.

there already exist early consoles. Please just use that infrastructure
instead.


