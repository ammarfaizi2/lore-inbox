Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262052AbTCRApS>; Mon, 17 Mar 2003 19:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262053AbTCRApS>; Mon, 17 Mar 2003 19:45:18 -0500
Received: from zamok.crans.org ([138.231.136.6]:57527 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id <S262052AbTCRApR>;
	Mon, 17 Mar 2003 19:45:17 -0500
Date: Tue, 18 Mar 2003 01:56:12 +0100
To: Torrey Hoffman <thoffman@arnor.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: (2.5.65) Unresolved symbols in modules?
Message-ID: <20030318005612.GA1529@darwin.crans.org>
References: <1047948471.12620.9.camel@rohan.arnor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047948471.12620.9.camel@rohan.arnor.net>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.3i
From: Vincent Hanquez <tab@tuxfamily.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 04:46:57PM -0800, Torrey Hoffman wrote:
> and then:
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.65; fi
                             ^^^^^^^^^^^^
you seem to use old depmod (not /usr/local/sbin/depmod)

-- 
Vincent Hanquez [Tab]
