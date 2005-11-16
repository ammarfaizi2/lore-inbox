Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030442AbVKPTVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030442AbVKPTVu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 14:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030444AbVKPTVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 14:21:50 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:29596 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030442AbVKPTVt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 14:21:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qI6T0KBv6OZfA9DPiUW57RjcBemeyDZUK4narajBfMa2E7CxXYUjXwhqnmryuVvCsQnYqSP291ZO1lrcMjVow7dq2/EMGUxxOAObyN+jq4ylWfqaw0PpTgW8G7dPYZypwFwBaDCXaeFffsgzI28qmxpmyQ693YU2AQNWlYTlGac=
Message-ID: <f1079b100511161121g1997cfb4jc8e8aec5072c1d92@mail.gmail.com>
Date: Wed, 16 Nov 2005 13:21:48 -0600
From: Scott Garfinkle <scotteglist@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/15] misc: Make x86 doublefault handling optional
In-Reply-To: <20051116182145.GP31287@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <8.282480653@selenic.com> <200511160713.07632.rob@landley.net>
	 <20051116182145.GP31287@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tend to agree with the spirit of Andi's comment -- disabling this
will (I think) make the rare time when it happens into something
impossible to debug without a new kernel and reproducing the problem.
Not being familiar with EMBEDDED, I am curious whether the savings is
critical.
