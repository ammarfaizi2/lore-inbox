Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318153AbSHPVAr>; Fri, 16 Aug 2002 17:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318174AbSHPVAr>; Fri, 16 Aug 2002 17:00:47 -0400
Received: from holomorphy.com ([66.224.33.161]:34240 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318153AbSHPVAq>;
	Fri, 16 Aug 2002 17:00:46 -0400
Date: Fri, 16 Aug 2002 14:03:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [PATCH] add buddyinfo /proc entry
Message-ID: <20020816210311.GY15685@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>, Dave Hansen <haveblue@us.ibm.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>
References: <3D5C6410.1020706@us.ibm.com> <3D5D0CC5.768BEAE8@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D5D0CC5.768BEAE8@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
+static void frag_stop(struct seq_file *m, void *arg)
+{
+       (void)m;
+       (void)arg;
+}

On Fri, Aug 16, 2002 at 07:31:33AM -0700, Andrew Morton wrote:
> Don't tell me the compiler warns about this now?

Woops -- that's actually a wli dropping. Some (?) of my code was
borrowed for this. Someone pounded -Werror into my head too hard
at school or something.


Cheers,
Bill
