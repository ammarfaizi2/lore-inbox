Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262588AbVCWO2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262588AbVCWO2r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 09:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVCWO2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 09:28:47 -0500
Received: from duempel.org ([81.209.165.42]:55239 "HELO swift.roonstrasse.net")
	by vger.kernel.org with SMTP id S262621AbVCWO2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 09:28:37 -0500
Date: Wed, 23 Mar 2005 15:27:53 +0100
From: Max Kellermann <max@duempel.org>
To: Natanael Copa <mlists@tanael.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: forkbombing Linux distributions
Message-ID: <20050323142753.GA23454@roonstrasse.net>
Mail-Followup-To: Natanael Copa <mlists@tanael.org>,
	linux-kernel@vger.kernel.org
References: <e0716e9f05032019064c7b1cec@mail.gmail.com> <20050322112628.GA18256@roll> <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr> <20050323135317.GA22959@roonstrasse.net> <1111587814.27969.86.camel@nc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111587814.27969.86.camel@nc>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005/03/23 15:23, Natanael Copa <mlists@tanael.org> wrote:
> On Wed, 2005-03-23 at 14:53 +0100, Max Kellermann wrote:
> > The number of processes is counted per user, but CPU time and memory
> > consumption is counted per process.
> 
> So limiting maximum number of processes will automatically limit CPU
> time and memory consumption per user?

No. I was talking about RLIMIT_CPU and RLIMIT_DATA, compared to
RLIMIT_NPROC. RLIMIT_NPROC limits the number of processes for that
user, nothing else (slightly simplified explanation).

Max

