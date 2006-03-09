Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWCIRUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWCIRUH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 12:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWCIRUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 12:20:06 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:57510 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750775AbWCIRUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 12:20:05 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 1 of 20] ipath - core driver header files
X-Message-Flag: Warning: May contain useful information
References: <55ad4136aa293c14dccc.1141922814@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 09:19:59 -0800
In-Reply-To: <55ad4136aa293c14dccc.1141922814@localhost.localdomain> (Bryan O'Sullivan's message of "Thu,  9 Mar 2006 08:46:54 -0800")
Message-ID: <adaek1blem8.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Mar 2006 17:20:01.0352 (UTC) FILETIME=[B2B12C80:01C6439D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +#include "ipath_common.h"
 > +#include "ipath_debug.h"
 > +#include "ipath_registers.h"
 > +#include <linux/interrupt.h>
 > +#include <asm/io.h>

The usual style is to include <linux/> first, then <asm/>, and finally
your own local headers.

 - R.
