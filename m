Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVASWjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVASWjH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 17:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVASWjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 17:39:06 -0500
Received: from peabody.ximian.com ([130.57.169.10]:65484 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261941AbVASWjE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 17:39:04 -0500
Subject: Re: 2.6.10-mm1 hang
From: Robert Love <rml@novell.com>
To: linux-os@analogic.com
Cc: Andrew Morton <akpm@osdl.org>, Badari Pulavarty <pbadari@us.ibm.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0501191658020.11665@chaos.analogic.com>
References: <1106153215.3577.134.camel@dyn318077bld.beaverton.ibm.com>
	 <20050119133136.7a1c0454.akpm@osdl.org>
	 <Pine.LNX.4.61.0501191658020.11665@chaos.analogic.com>
Content-Type: text/plain
Date: Wed, 19 Jan 2005 17:40:57 -0500
Message-Id: <1106174457.5907.40.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-19 at 17:01 -0500, linux-os wrote:

> What would you expect this to do? After the first lock is
> obtained, the second MUST fail forever or else the spin-lock
> doesn't work. The code, above, just proves that spin-locks
> work!

He has a four processor machine.  Since the lock is local, it is
somewhat odd that the other three lock up.

	Robert Love


