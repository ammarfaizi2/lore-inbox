Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbVBXPAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbVBXPAh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 10:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbVBXO77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 09:59:59 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:62181 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262366AbVBXOvT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 09:51:19 -0500
Date: Thu, 24 Feb 2005 08:46:51 -0600
To: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <pol-admin@uni-duisburg.de>
Cc: linux-kernel@vger.kernel.org, nettings@folkwang-hochschule.de
Subject: Re: FUTEX deadlock in ping?
Message-ID: <20050224144651.GA5702@austin.ibm.com>
References: <421DA915.7020209@uni-duisburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <421DA915.7020209@uni-duisburg.de>
User-Agent: Mutt/1.5.6+20040523i
From: olof@austin.ibm.com (Olof Johansson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 11:14:45AM +0100, Jörn Nettingsmeier wrote:

> futex(0x401540f4, FUTEX_WAIT, 2, NULL
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> is this one related to the FUTEX problem olof described?

As bert said, it's likely something else. Is the process killable, and
does "ps aux" complete? If so, then this is a different problem.


-Olof

