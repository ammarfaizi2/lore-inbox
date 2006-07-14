Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422746AbWGNUHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422746AbWGNUHG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 16:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422751AbWGNUHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 16:07:05 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:17025 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422746AbWGNUHA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 16:07:00 -0400
Subject: Re: [RFC][PATCH 3/6] SLIM main patch
From: Dave Hansen <haveblue@us.ibm.com>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
In-Reply-To: <1152907301.23584.38.camel@localhost.localdomain>
References: <1152897878.23584.6.camel@localhost.localdomain>
	 <1152901664.314.35.camel@localhost.localdomain>
	 <1152907301.23584.38.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 13:06:53 -0700
Message-Id: <1152907613.314.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 13:01 -0700, Kylene Jo Hall wrote:
> On closer look combining these would require collapsing them into one
> enum or returning int and doing a bunch of casting.  Kind of seems to
> void the point of using an enum.  Thus I propose leaving them as is,
> okay?

Certainly.  I'm just glad they got another look.

As I look again... Can you use ARRAY_SIZE() on them?

-- Dave

