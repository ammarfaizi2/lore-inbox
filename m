Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbVDGNOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbVDGNOw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 09:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVDGNOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 09:14:51 -0400
Received: from ns1.iptel.by ([80.94.225.5]:54207 "EHLO iptel.by")
	by vger.kernel.org with ESMTP id S262457AbVDGNOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 09:14:33 -0400
Subject: Re: /dev/random problem on 2.6.12-rc1
From: Yura Pakhuchiy <pakhuchiy@iptel.by>
To: Patrice Martinez <patrice.martinez@ext.bull.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42552A33.6070704@ext.bull.net>
References: <42552A33.6070704@ext.bull.net>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 16:14:26 +0300
Message-Id: <1112879666.2035.10.camel@chaos.void>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-07 at 14:40 +0200, Patrice Martinez wrote:
> When  using a machine with a  2612-rc 1kernel, I encounter problems 
> reading /dev/random:
>  it simply nevers returns anything, and the process is blocked in the 
> read...
> The easiest way to see it is to type:
>  od < /dev/random
> 
> Any idea?

Because, /dev/random use user input, mouse movements and other things to
generate next random number. Use /dev/urandom if you want version that
will never block your machine.

Read "man 4 random" for details.

Best regards,
	Yura

