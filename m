Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbTJPHsd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 03:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262748AbTJPHsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 03:48:33 -0400
Received: from main.gmane.org ([80.91.224.249]:55180 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262746AbTJPHsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 03:48:32 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: About _real_ free memory
Date: Thu, 16 Oct 2003 09:48:30 +0200
Message-ID: <yw1xsmltaai9.fsf@users.sourceforge.net>
References: <D9B4591FDBACD411B01E00508BB33C1B01F6EA74@mesadm.epl.prov-liege.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:xVFe6nkfpolXVHDoel9wB3XkIyE=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Frederick, Fabian" <Fabian.Frederick@prov-liege.be> writes:

> Is there a way to clean cache from unwanted data or something to
> unlink the stuff and regain some more 'free' mem. ?

If a process tries to allocate and use more than the really free
amount, some cache will be dropped automatically.  From a performance
point of view, this could of course be undesirable, but normally
there's no need to think about it.

-- 
Måns Rullgård
mru@users.sf.net

