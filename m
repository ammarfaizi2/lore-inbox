Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279275AbRJWGUo>; Tue, 23 Oct 2001 02:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279276AbRJWGUe>; Tue, 23 Oct 2001 02:20:34 -0400
Received: from zero.tech9.net ([209.61.188.187]:54538 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S279275AbRJWGUU>;
	Tue, 23 Oct 2001 02:20:20 -0400
Subject: Re: Why XFS not in the main kernel?
From: Robert Love <rml@tech9.net>
To: Anuradha Ratnaweera <anuradha@gnu.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011023113546.A1310@bee.lk>
In-Reply-To: <20011023113546.A1310@bee.lk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.18.15.19 (Preview Release)
Date: 23 Oct 2001 02:21:05 -0400
Message-Id: <1003818066.1491.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-10-23 at 01:35, Anuradha Ratnaweera wrote:
> Is there a reason not to include XFS in the mainstream kernel?  It is very
> stable and many (including us) are using it in production environments without
> problems.
> 
> Obviously, there can't be liscening issues, because XFS is released under GPL.

No one doubts XFS is stable.  It is a great fs.  But XFS includes some
modifications to block layer and such that people aren't ready to merge
yet -- XFS touches a lot of stuff.  During 2.5, the better bits of the
modifications will be used and then XFS can be merged properly.  Perhaps
once this proves stable a backport to 2.4 can be done.

	Robert Love

