Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269414AbUINPrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269414AbUINPrA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269441AbUINPoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:44:08 -0400
Received: from holomorphy.com ([207.189.100.168]:31124 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269442AbUINPlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:41:49 -0400
Date: Tue, 14 Sep 2004 08:41:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Leuthi <rl@hellgate.ch>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Albert Cahalan <albert@users.sf.net>
Subject: Re: [pidhashing] [2/3] lower PID_MAX_LIMIT for 32-bit machines
Message-ID: <20040914154144.GQ9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914022530.GO9106@holomorphy.com> <20040914022827.GP9106@holomorphy.com> <20040914023114.GQ9106@holomorphy.com> <20040914105527.GB11238@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914105527.GB11238@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004 19:31:14 -0700, William Lee Irwin III wrote:
>> -#define PID_MAX_LIMIT (4*1024*1024)
>> +#define PID_MAX_LIMIT (sizeof(long) > 32 ? 4*1024*1024 : PID_MAX_DEFAULT)

On Tue, Sep 14, 2004 at 12:55:27PM +0200, Roger Luethi wrote:
> An architecture with sizeof(long) > 32? -- Most impressive.

Did the correction not arrive?


-- wli
