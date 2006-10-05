Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWJEA2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWJEA2N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 20:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWJEA2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 20:28:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1992 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751253AbWJEA2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 20:28:10 -0400
Date: Wed, 4 Oct 2006 17:28:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>,
       "ACPI List" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] Cast removal
Message-Id: <20061004172804.1704225e.akpm@osdl.org>
In-Reply-To: <B28E9812BAF6E2498B7EC5C427F293A40111D341@orsmsx415.amr.corp.intel.com>
References: <B28E9812BAF6E2498B7EC5C427F293A40111D341@orsmsx415.amr.corp.intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2006 14:40:56 -0700
"Moore, Robert" <robert.moore@intel.com> wrote:

> Most of the casting stuff is because ACPICA has to support a bunch of
> different compilers.

What compiler generates a warning when you fail to cast a void*?  That's
standard C isn't it?
