Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266528AbTAOPz5>; Wed, 15 Jan 2003 10:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266645AbTAOPz5>; Wed, 15 Jan 2003 10:55:57 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:28167 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266528AbTAOPz4>; Wed, 15 Jan 2003 10:55:56 -0500
Date: Wed, 15 Jan 2003 16:04:49 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Cc: ak@muc.de, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linux-security-module@wirex.com, viro@math.psu.edu
Subject: Re: [RFC] Changes to the LSM file-related hooks for 2.5.58
Message-ID: <20030115160449.A15515@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Stephen D. Smalley" <sds@epoch.ncsc.mil>, ak@muc.de,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@wirex.com, viro@math.psu.edu
References: <200301151544.KAA17539@moss-shockers.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301151544.KAA17539@moss-shockers.ncsc.mil>; from sds@epoch.ncsc.mil on Wed, Jan 15, 2003 at 10:44:52AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 10:44:52AM -0500, Stephen D. Smalley wrote:
> + * caller must verify that inode->i_fop is not NULL.  The file should

Oh, and this comment was and still is wrong 8)

