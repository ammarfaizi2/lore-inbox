Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVFNJcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVFNJcZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 05:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVFNJcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 05:32:25 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:571 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261158AbVFNJcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 05:32:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=FUKG5zsjNJGFC3sXR8SZkp0v35fPWqqmINgrdJmPrf4+SuZcRkD+4sZB6GGbkEi5lzGzWDfX/tIQsfUl5qufDeE5JNzG5LnwEmiFCDjKESE/8iJoGtTrQx9xYAZDYi31B2JdKPE4Dw01evr3T/QlgTyj9zNjKhRCV94cB5Em/rs=
Subject: Re: A Great Idea (tm) about reimplementing NLS.
From: Islam Amer <pharon@gmail.com>
Reply-To: pharon@gmail.com
To: linux-kernel@vger.kernel.org
In-Reply-To: <1118685680.18189.3.camel@localhost>
References: <f192987705061303383f77c10c@mail.gmail.com>
	 <42AD649E.1020901@stesmi.com>  <1118685680.18189.3.camel@localhost>
Content-Type: text/plain
Date: Tue, 14 Jun 2005 12:32:02 +0300
Message-Id: <1118741522.9059.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
A related issue I had is that some codepages don't have a nls module
yet. 
For example I once or twice needed to mount a vfat filesystem with
cp1256 ( arabic windows ) charset. There is no such nls module. I
couldn't find any documentation about how to create the module ( maybe I
didn't look hard enough ).
Therefore a filesystem used by old windows versions having arabic names
is unusable.

