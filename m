Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132308AbRBRBl1>; Sat, 17 Feb 2001 20:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132452AbRBRBlT>; Sat, 17 Feb 2001 20:41:19 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:7906 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132308AbRBRBlF>; Sat, 17 Feb 2001 20:41:05 -0500
Message-ID: <3A8F2A5D.D272DA8@uow.edu.au>
Date: Sun, 18 Feb 2001 12:50:21 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "J . A . Magallon" <jamagallon@able.es>
CC: Keith Owens <kaos@ocs.com.au>, Hugh Dickins <hugh@veritas.com>,
        Paul Gortmaker <p_gortmaker@yahoo.com>,
        linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] a more efficient BUG() macro
In-Reply-To: <20010218013353.A1331@werewolf.able.es> <19480.982457293@ocs3.ocs-net> <3A8F266F.AFA01552@uow.edu.au>,
		<3A8F266F.AFA01552@uow.edu.au>; from andrewm@uow.edu.au on Sun, Feb 18, 2001 at 02:33:35 +0100 <20010218023714.C951@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" wrote:
> 
> On 02.18 Andrew Morton wrote:
> >
> > __BASE_FILE__ does this.  It expands to the thing which you
> > typed on the `gcc' command line.
> >
> ..
> > 3 at a.c
> > 3 at a.c
> 
> I also thought that, but look at the line numbers...wrong and repeated.

Sure.  There's no __BASE_LINE__.

I don't think providing file-n-line in BUG() provides much utility. Just
remove it.  Replace it with "please feed the following into ksymoops".
