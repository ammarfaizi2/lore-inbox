Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWCCLng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWCCLng (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 06:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWCCLng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 06:43:36 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:61743 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751416AbWCCLng convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 06:43:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dGf8zyw59VMtxVD6r5wElATP1bkjlRJzjyRHn/qonxP2YKSxhb/Rxva+bqzQRVTCojoY8LFZMg/BJkzLBZJ/FzBrPutRYDnP5LTNoTZ4HMW0peXiCXJoRLezYDM2TAtcYy5STm2NcwlQbjb4r8W4G4FE1pdrTluN+5kDEwUNcXo=
Message-ID: <105c793f0603030343n37be276dp73c2603cf1ed18fe@mail.gmail.com>
Date: Fri, 3 Mar 2006 06:43:35 -0500
From: "Andrew Haninger" <ahaning@gmail.com>
To: "tim tim" <tictactoe.tim@gmail.com>
Subject: Re: module-init-tools invain
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <503e0f9d0603030003i566d29ecj3c476d245a42f17a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <503e0f9d0603030003i566d29ecj3c476d245a42f17a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/06, tim tim <tictactoe.tim@gmail.com> wrote:
> i downloaded the tool and installed as was given in the readme file..
> then i followed my procedure of kernel installation.. now also.. i get
> same depmod.. problemm..
Perhaps you need to uninstall your old modutils installation? I know
that modutils and module-init-tools can exist on the same machine, but
it might be easier and clearer to know which one is causing problems
if you have just one installed.

> but when i run the command
> depmod 2.6.10 from that kernel directory it says nothing.. not even
> error .. what can i do..
I've always used depmod -a.

But again, be sure you're using the module-init-tools version of
depmod and not your old modutils copy.

-Andy
