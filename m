Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbTENEon (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 00:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbTENEon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 00:44:43 -0400
Received: from holomorphy.com ([66.224.33.161]:31936 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261819AbTENEom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 00:44:42 -0400
Date: Tue, 13 May 2003 21:57:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org, axel@pearbough.net
Subject: Re: drivers/scsi/aic7xxx/aic7xxx_osm.c: warning is error
Message-ID: <20030514045718.GK8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, axel@pearbough.net
References: <20030514004009.GA20914@neon.pearbough.net> <20030514031826.GB29926@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514031826.GB29926@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 02:40:09AM +0200, axel@pearbough.net wrote:
>> today compiled 2.5.69-bk8 with gcc version 3.3 20030510 and a warning in
>> drivers/scsi/aic7xxx/aic7xxx_osm.c resulted in an error because of gcc flag
>> -Werror.

On Tue, May 13, 2003 at 08:18:26PM -0700, William Lee Irwin III wrote:
> I can't reproduce this with gcc-3.2; does this do better?
> I also removed some extremely fishy arithmetic in a check for crossing
> 4GB boundaries; I hope you don't mind.

I installed gcc-3.3 and reproduced it and sent in a slightly different
fix.


-- wli
