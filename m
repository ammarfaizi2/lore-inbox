Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbUKHSdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbUKHSdh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 13:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbUKHSdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 13:33:02 -0500
Received: from agminet02.oracle.com ([141.146.126.229]:25229 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S261185AbUKHS3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 13:29:32 -0500
Date: Mon, 8 Nov 2004 10:29:09 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: suparna@in.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Fix O_SYNC speedup for generic_file_write_nolock
Message-ID: <20041108182909.GS12500@ca-server1.us.oracle.com>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	suparna@in.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <20041108100738.GA4003@in.ibm.com> <1099908278.3577.2.camel@laptop.fenrus.org> <20041108115353.GA4068@in.ibm.com> <1099915544.3577.9.camel@laptop.fenrus.org> <20041108152043.GR12500@ca-server1.us.oracle.com> <1099927877.3577.15.camel@laptop.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099927877.3577.15.camel@laptop.fenrus.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 04:31:17PM +0100, Arjan van de Ven wrote:
> On Mon, 2004-11-08 at 07:20 -0800, Joel Becker wrote:
> > 	OCFS2 uses generic_file_write_nolock(), and as such we might
> > want to look into this problem and the sync_page_range_nolock() fix.
> 
> are you going to submit ocfs2 soon for inclusion ?

	FSVO "soon", yes.

Joel


-- 

Life's Little Instruction Book #157 

	"Take time to smell the roses."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
