Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbTFFOaR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 10:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbTFFOaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 10:30:17 -0400
Received: from holomorphy.com ([66.224.33.161]:14272 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261790AbTFFOaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 10:30:16 -0400
Date: Fri, 6 Jun 2003 07:43:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jasper Spaans <jasper@vs19.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] fix location of zap_low_mappings
Message-ID: <20030606144346.GF8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jasper Spaans <jasper@vs19.net>, linux-kernel@vger.kernel.org
References: <20030606095749.GA13037@spaans.vs19.net> <20030606113443.GD8978@holomorphy.com> <20030606143335.GA25574@spaans.vs19.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030606143335.GA25574@spaans.vs19.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 06, 2003 at 04:34:43AM -0700, William Lee Irwin III wrote:
>> It's basically not supposed to be visible on UP. Perhaps a better
>> approach would be declare it in pgtable.h as you did, stub out the UP
>> case with an empty function, and un-#ifdef it from mem_init().

On Fri, Jun 06, 2003 at 04:33:35PM +0200, Jasper Spaans wrote:
> That wouldn't seem right to me:

Yeah. That suggestion was totally bogus. Fine as-is then.

-- wli
