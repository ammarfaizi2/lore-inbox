Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277476AbRJJWWr>; Wed, 10 Oct 2001 18:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277487AbRJJWWh>; Wed, 10 Oct 2001 18:22:37 -0400
Received: from are.twiddle.net ([64.81.246.98]:43942 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S277476AbRJJWWW>;
	Wed, 10 Oct 2001 18:22:22 -0400
Date: Wed, 10 Oct 2001 15:22:51 -0700
From: Richard Henderson <rth@twiddle.net>
To: Paul McKenney <Paul.McKenney@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        Paul Mackerras <paulus@samba.org>
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011010152251.A31099@twiddle.net>
Mail-Followup-To: Paul McKenney <Paul.McKenney@us.ibm.com>,
	linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
	Paul Mackerras <paulus@samba.org>
In-Reply-To: <OF99CB0435.488D4308-ON88256AE1.0077A859@boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OF99CB0435.488D4308-ON88256AE1.0077A859@boulder.ibm.com>; from Paul.McKenney@us.ibm.com on Wed, Oct 10, 2001 at 02:47:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 02:47:05PM -0700, Paul McKenney wrote:
> Just to make sure I understand...  This rmbdd() would use IPIs to
> get all the CPUs' caches synchronized, right?

No, it would expand to rmb on Alpha, and to nothing elsewhere.


r~
