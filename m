Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267274AbTGHMYF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 08:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267275AbTGHMYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 08:24:05 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:54444 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S267274AbTGHMYC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 08:24:02 -0400
Date: Tue, 8 Jul 2003 23:43:26 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Wim ten Have <wtenhave@sybase.com>
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: Bug fix in AIO initialization
Message-ID: <20030708234326.A2352@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <41F331DBE1178346A6F30D7CF124B24B2A4880@fmsmsx409.fm.intel.com> <20030708115345.5e6e5bbc.wtenhave@sybase.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030708115345.5e6e5bbc.wtenhave@sybase.com>; from wtenhave@sybase.com on Tue, Jul 08, 2003 at 11:53:45AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 11:53:45AM +0200, Wim ten Have wrote:
>    Is there a definition how long system calls take when i issue
>    asynchronous read/write requests?  The purpose is to not block
>    but occasionally i measure up to 100's of milliseconds before
>    the request is accepted or returns that there are currently
>    no resources making me try again.  Is this normal?

Is this with vanilla 2.5 kernels or recent -mm kernels ?

Are you doing async O_DIRECT reads/writes or regular filesystem
aio read/writes ?

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

