Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266246AbSKUBBH>; Wed, 20 Nov 2002 20:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266250AbSKUBBH>; Wed, 20 Nov 2002 20:01:07 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:12551
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S266246AbSKUBBF>; Wed, 20 Nov 2002 20:01:05 -0500
Subject: Re: [Coding style question] XXX_register or register_XXX
From: Robert Love <rml@tech9.net>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001701c290ef$8417f020$94d40a0a@amr.corp.intel.com>
References: <001701c290ef$8417f020$94d40a0a@amr.corp.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1037840908.1253.3178.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 20 Nov 2002 20:08:28 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 18:49, Rusty Lynch wrote:

> Is there an accepted standard on naming for registration functions?  If have
> a foo object that other things can register and unregister with,
> should the function names be:

I do not think there is an accepted practice here.

> int register_foo(&something);
> int unregister_foo(&something);

I bet this is more common.

> int foo_register(&something);
> int foo_unregister(&something);

But I prefer this - I like there to be a namespace for a given subsystem
and for it to be a prefix.

	Robert Love

