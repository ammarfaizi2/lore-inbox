Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318503AbSHPOQ4>; Fri, 16 Aug 2002 10:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318514AbSHPOQ4>; Fri, 16 Aug 2002 10:16:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53260 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318503AbSHPOQz>;
	Fri, 16 Aug 2002 10:16:55 -0400
Message-ID: <3D5D0CC5.768BEAE8@zip.com.au>
Date: Fri, 16 Aug 2002 07:31:33 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [PATCH] add buddyinfo /proc entry
References: <3D5C6410.1020706@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> 
> ..
> +static void frag_stop(struct seq_file *m, void *arg)
> +{
> +       (void)m;
> +       (void)arg;
> +}

Don't tell me the compiler warns about this now?
